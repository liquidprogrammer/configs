let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['eslint']

" requires a defined script in package.json (something like that):
"   "eslint": "eslint -c .eslintrc.json --"
let g:syntastic_javascript_eslint_exe = 'npm run eslint'
