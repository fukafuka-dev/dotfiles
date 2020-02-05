#!/usr/bin/ruby

require 'optparse'

DEFAULT_DIR = "#{Dir.home}/doc/memo".freeze

def params
  hash = {}
  opt = OptParse.new
  opt.on('--config [PATH]') { |path| hash[:config] = path || true }
  opt.on('--grep KEYWORD') { |keyword| hash[:grep] = keyword }
  args = opt.parse(ARGV)
  { args: args, opts: hash }
end

def open_memo(path)
  exec("vim \"#{path}\" < /dev/tty")
end

def action(params)
  opts = params[:opts]
  work_dir = DEFAULT_DIR

  # script exits after echo current work directory path.
  exec("echo #{work_dir}") if opts[:config] == true

  work_dir = opts[:config] if opts[:config]

  # script exits after grep with option parameter.
  exec("ag #{opts[:grep]} #{work_dir}") if opts[:grep]

  filename = params[:args].first

  if filename.nil?
    if Dir.exist?(work_dir)
      # browse file with fzf
      select_filename = `ls #{work_dir} | fzf --preview "head -100 #{work_dir}/{}"`
      open_memo("#{work_dir}/#{select_filename.chomp}") unless select_filename.empty?
    end
  else
    exit unless system("mkdir -p #{work_dir}")
    open_memo("#{work_dir}/#{filename}.md")
  end
end

action(params)
