#!/usr/bin/ruby -w


require 'find'

dirname = Dir.pwd
outfilename = 'output.txt'

array = []
Find.find(dirname) do |path|
    filename = File.basename(path)
    if filename.include?("mp4") == true
        array.push(filename)
    end
end
array.sort_by! do |name|
    name.split(".")[1].to_i
end
array.collect!{|item| "file '" + item + "'" }

if !File::exist?(outfilename)
    File.new(outfilename, "w+")
end

f = File.open(outfilename, 'w')
f.puts array
f.close

if array.length > 0
    exec 'ffmpeg -f concat -i output.txt -c copy output.mp4'
    else
    puts "😢😢😢～～～数据异常～～～😢😢😢"
end
puts "～～～执行完毕～～～"
