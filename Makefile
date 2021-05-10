setup:
	./bin/setup.sh

setup_tmux:
	./bin/setup_tmux.sh

link:
	./bin/link.sh

install: setup setup_tmux link
