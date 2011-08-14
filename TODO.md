
### todo

* Rake is good, let's use it. *All* steps should go through rake.

* path_to is a good idea, let's use it. Stamp out the `File.join(path_to(:rawd_dir), 'your_mom')` in favor of simply `path_to(:rawd_dir, 'your_mom')`

* need to invoke `WorkingConfig.resolve!`

* the task `init.rb` should not be the task that runs my shit.

### utils/path.rb

* I can't override paths in advance.
* the code_root stuff is borked. Doesn't work well as a gem, doesn't work well
  if not in a blessed hierarchy.


### tasks/mini.rb

* Please rethink -- the whole point should be that these are identical flows
* Why no use setting `--mini`?
* What's up with 
    Opts = Configliere::Param.new.use :commandline
    Opts.define :files, :type => Array
    Opts.resolve!

### hackboxen.rb

* (require > require > include > require > autoload) soup 
* Among other things, I'd like access to things WITHOUT having to require rake, etc.
* HackBoxen vs Hackboxen (please make underscored_names unambiguously match CamelizedNames)

