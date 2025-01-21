setup:
	./bin/setup.sh

setup-tmux:
	./bin/setup_tmux.sh

link:
	./bin/link.sh

install: setup setup-tmux link
