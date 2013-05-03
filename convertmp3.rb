require 'optparse'
require 'pathname'

# Define how to handle directory arguments
OptionParser.accept(Pathname) do |pn|
  if File.directory?(pn) # Make sure directory is valid
    Pathname.new(pn) 
  else
    raise OptionParser::InvalidArgument, pn
  end
end

# Set default values
options = {}
options[:bitrate] = 256

# Define acceptable input arguments
optparse = OptionParser.new do |opts|
  opts.on("-d","--dir DIR", Pathname, "Top level directory to begin processing.") do |x|
    options[:directory] = x
  end
  
  opts.on("-b","--bitrate [BR]", Integer, "MP3 Bit rate in kbps. Default = 256") do |x|
    options[:bitrate] = x
  end
  
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end  
end

# Parse input arguments
begin
  optparse.parse!
rescue OptionParser::InvalidArgument => e
  puts "Directory path is not valid: #{e.message}"
end

# check directory
if !options.has_key?(:directory)
  puts optparse
  abort("Missing input directory.")
end

# check bit rate
if !options[:bitrate].is_a? Integer || options[:bitrate] < 32 || options[:bitrate] > 320
  abort("Bit rate must be between 32 and 320.")
end

inputPath = options[:directory]

# Loop over all .flac files in this directory and all sub directories
Dir.glob(inputPath.expand_path + '**/*.flac').each do |flacFile|
  # check if .mp3 version already exists
  outFile = File.join( File.dirname(flacFile), File.basename(flacFile,'.*') + '.mp3')
  
  if File.exists?(outFile)  # skip processing if file already exists
	next
  end
  
  puts "Processing: " + flacFile
  
  # convert the file
  result = system("ffmpeg -loglevel quiet -i \"#{flacFile}\" -ab #{options[:bitrate]}k -map_metadata 0 -id3v2_version 3 -write_id3v1 1 \"#{outFile}\"")
  
  if result
   puts "Done"
  else
   puts "ffmpeg returned non-zero status code"
  end

end