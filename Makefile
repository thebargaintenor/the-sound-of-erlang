.PHONY: build
build:
	rebar3 escriptize

.PHONY: run
run:
	./_build/default/bin/the_sound_of_erlang sample.raw

.PHONY: noise
noise:
	# -f here marks a format of 64 bit big-endian float
	# -ar 48000 denotes 48kHz sample rate
	ffplay -f f64be -ar 48000 ./out/first_wave.raw

.PHONY: mp3
mp3:
	ffmpeg -f f64be -ar 48000 -i out/first_wave.raw out/first_wave.mp3
