#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'yaml'

class MetaBox

  attr_accessor :cache

  def initialize
    @cache = {}
    @unreadable = []
  end

  def lookup
    readable = {}
    paths_to_cfg.each do |path|
      config = read_config path
      if config
        name = config['namespace'] + '.' + config['protocol']
        readable[name] = path
      else
        @unreadable << path
      end
    end
    readable
  end

  def paths_to_cfg
    Dir["../**/config.yaml"]
  end

  def read_config cfg_path
    begin
      return config = YAML.load(File.read cfg_path)
    rescue
      return nil
    end
  end

  def add_to_cache *args
    args.flatten.each do |name|
      @cache[name] = read_config(lookup[name]) if lookup[name]
    end
    list_cache
  end

  def clear_cache
    @cache = {}
    list_cache
  end

  def list_readable
    lookup.keys
  end

  def list_cache
    @cache.keys
  end

  def describe name
    cfg = read_config(lookup[name]) if lookup[name]
    puts JSON.pretty_generate cfg
    name
  end

  def describe_cache *args
    if args.empty?
      @cache.each { |key, val| puts JSON.pretty_generate val }
      list_cache
    else
      args.each { |val| puts JSON.pretty_generate @cache[val] }
    end
  end

  def each_insert key, val
    @cache.each { |name, cfg| cfg[key] = val }
    describe_cache
  end

  def search query
    results = []
    lookup.each do |name, path|
      cfg = read_config path
      results << name if cfg[query]
    end
    results
  end

  def write_cache
    @cache.each do |name, cfg|
      File.open(lookup[name], 'w') do |file|
        file.puts cfg.to_yaml
      end
    end
    list_cache
  end

end

