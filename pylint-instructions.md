1) `pip install pylint`
2) `pip install pylint-django` Note that if this is not available and it is specified in :CocConfig's load-plugins, it will bork the process
3) `pylint --generate-rcfile > .pylintrc`
4) Add `pylint-django` to `load-plugins`
