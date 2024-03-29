PACKAGE = PACKAGE_NAME
PY = python
VENV = .env
TENV = .tenv
BIN = $(VENV)/bin
TIN = $(TENV)/bin

all: test .testenv

$(VENV): requirements.txt
	$(PY) -m venv $(VENV)
	$(BIN)/pip install --upgrade -r requirements.txt
	touch $(VENV)

$(TENV): testrequirements.txt setup.py
	$(PY) -m venv $(TENV)
	$(TIN)/pip install --upgrade -r testrequirements.txt
	$(TIN)/pip install -e .
	touch $(TENV)

.PHONY: serve
serve: doc
	cd docs/build/html && $(PY) -m http.server 8018

.PHONY: pypi
pypi: 
	python setup.py sdist
	twine upload dist/*

.PHONY: doc
doc: $(VENV)
	@cd docs && make clean
	@$(BIN)/sphinx-apidoc -o ./docs/source/ ./$(PACKAGE)
	@cd docs && make html

.PHONY: test
test: $(VENV)
	$(BIN)/pytest -s ./test/test.py 

clean:
	rm -rf $(VENV)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete

