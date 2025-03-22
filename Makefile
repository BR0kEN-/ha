.DEFAULT_GOAL := venv
.PHONY: venv

venv:
	test -d venv || python3 -m venv venv

i:
	pip3 install -e .

run:
	ansible-playbook provision.yml $(MAKEFLAGS)
