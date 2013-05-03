FLAC to MP3 Audio Converter
========

Description
--------

This program converts all **FLAC** audio files in a directory and all of its sub-directories to **MP3** format. The resulting MP3 format is suitable for playback on a range of devices including iOS (iPhone and iPad), Android, and Car Audio Receivers.

All metadata information will be copied to the resulting MP3 ID3 tag. The audio stream bit rate can be specified to balance desired quality and disk space usage.

Requirements
--------

The [ffmpeg program](http://www.ffmpeg.org/) must be installed and in your system path.

Usage
--------

This program runs using Ruby 2.0. 

	Usage: convertmp3 [options]
		-d, --dir DIR                    Top level directory to begin processing.
		-b, --bitrate [BR]               MP3 Bit rate in kbps. Default = 256
		-h, --help                       Display this screen

Example:

    > ruby convertmp3.rb -d /path/to/music -b 192


