.PHONY: help clean clean-pyc clean-build list test test-all coverage docs dist release

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "testall - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "dist - build the package"
	@echo "release - build and upload a release to github"

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

lint:
	flake8 frecency test

test:
	py.test

test-all:
	tox

coverage:
	coverage run --source frecency setup.py test
	coverage report -m
	coverage html
	open htmlcov/index.html

docs:
	rm -f docs/frecency.rst
	rm -f docs/modules.rst
	sphinx-apidoc -o docs/ frecency
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	open docs/_build/html/index.html

dist: clean
	nix-shell --pure --run "python -m build"

release: clean
	nix-shell --pure --run "python -m build"
	nix-shell --pure --run 'scripts/create_github_release.py'
