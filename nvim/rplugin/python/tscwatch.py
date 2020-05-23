#!/usr/bin/env python3
#
# tscwatch.py
#

import pynvim

import re
from threading import Thread
from subprocess import Popen, PIPE

##
##  QuickFix
##
class QuickFix(object):

    def __init__(self, nvim):
        self.nvim = nvim

    # init()
    def init(self, title=''):
        # clear
        self.nvim.async_call(self.nvim.command, 'call setqflist([], "r")')
        # set title
        self.nvim.async_call(self.nvim.command, 'call setqflist([], "r", ' +
            '{"title": "%s"})' % title)

    # _escape()
    def _escape(self, s):
        return s.replace('\'', '\\\'').replace('"', '\\"')

    # open()
    def open(self):
        self.nvim.async_call(self.nvim.command, 'echo "QF open"')
        self.nvim.async_call(self.nvim.command, 'copen')

    # close()
    def close(self):
        self.nvim.async_call(self.nvim.command, 'echo "QF close"')
        self.nvim.async_call(self.nvim.command, 'cclose')

    # append()
    def append(self,
        filename='', line=0, col=0, desc=''):
        self.nvim.async_call(self.nvim.command, 'echo "Append"')
        self.nvim.async_call(self.nvim.command, 'call setqflist([{' +
                '"filename": "%s",' % (self._escape(filename)) +
                '"lnum": %d,' % (line) +
                '"col": %d,' % (col) +
                '"text": "%s"' % (self._escape(desc)) +
                '}], "a")')

##
##  TscWatchThread
##
class TscWatchThread(Thread):

    PAT_START = re.compile(r'Starting .*compilation')
    PAT_END = re.compile(r'Watching for file changes\.')
    PAT_ERROR = re.compile(r'(.+)\((\d+),(\d+)\): (.*)')

    def __init__(self, nvim, cmds=[]):
        Thread.__init__(self)
        self.cmds = cmds
        self.proc = None
        self.nvim = nvim
        self.isTscStarted = False

    def run(self):
        self.proc = Popen(self.cmds, stdout=PIPE, stderr=PIPE)
        procname = ' '.join(self.cmds)

        qf = QuickFix(self.nvim)
        qf.init(title=procname)
        isTscFailed = False
        while True:
            line = self.proc.stdout.readline()
            if line == b'':
                break
            s = line.decode('utf-8').strip()
            if s == '':
                continue
            if self.PAT_START.search(s) is not None:
                self.isTscStarted = True
                isTscFailed = False
                qf.init(title=procname)
            elif self.PAT_END.search(s) is not None:
                self.isTscStarted = False
                if isTscFailed:
                    qf.open()
                else:
                    qf.close()
                    print('Done: %s' % procname)
            elif self.isTscStarted:
                if not isTscFailed:
                    isTscFailed = True
                m = self.PAT_ERROR.search(s)
                if m is not None:
                    # append error.
                    qf.append(
                        filename=m.group(1),
                        line=int(m.group(2)),
                        col=int(m.group(3)),
                        desc=m.group(4))
                else:
                    # unknown pattern
                    qf.append(desc=s)
                    qf.open()
            self.nvim.async_call(self.nvim.command, 'redraw')

    def stop(self):
        self.proc.terminate()


##
##  TscWatchRunner
##

@pynvim.plugin
class TscWatchRunner(object):

    def __init__(self, nvim):
        self.tsc_thread = None
        self.nvim = nvim

    def _is_running(self):
        return (self.tsc_thread is not None and
            self.tsc_thread.is_alive())

    @pynvim.command('TscWatchStart', sync=True)
    def start(self, cmd='tsc', arg=''):
        if self._is_running():
            self.nvim.command('echo "Already started"')
            return

        self.tsc_thread = TscWatchThread(self.nvim, ['npm', 'run', 'ts_watch'])
        self.tsc_thread.start()
        self.nvim.command('echo "Started"')

    @pynvim.command('TscWatchStop', sync=True)
    def stop(self):
        if self.tsc_thread is None:
            self.nvim.command('echo "Not started"')
            return
        if self.tsc_thread.is_alive():
            self.tsc_thread.stop()
            self.tsc_thread.join()
        self.tsc_thread = None
        self.nvim.command('echo "Stopped"')

    @pynvim.command('TscWatchRestart', sync=True)
    def restart(self):
        if self._is_running():
            cmds = self.tsc_thread.cmds
            self.stop()
            self.tsc_thread = TscWatchThread(self.nvim, cmds)
            self.tsc_thread.start()
        else:
            self.nvim.command('echo "Not started"')

    @pynvim.command('TscWatchIsRunning', sync=True)
    def is_running(self):
        if self._is_running():
            self.nvim.command('echo "Running"')
        else:
            self.nvim.command('echo "Not started"')

