module HackBoxen

  class ConfigValidator

    # This makes sure the "requires" are met by the "provides"
    # in the hackbox config. Failures are stored in <tt>fails</tt>.
    def self.failed_requirements
      p = WorkingConfig['provides']
      r = WorkingConfig['requires']
      fails = []
      if r != nil
        if not r.class == Hash  or not p.class == Hash
          fails << "'requires' and 'provides' must be Hash"
        else
          fails += self.match_requirements r, p
        end
      end
      fails
    end

    # Recursive. r and p must be hashes.
    def self.match_requirements r,p,path=""
      fails = []
      r.keys.each { |k|
        if not p.has_key? k
          fails << "Missing #{path}/#{k}"
        else
          if r[k].class == Hash
            if p[k].class != Hash
              fails << "'provides' #{path}/#{k} should be a hash because 'requires' is."
            else
              fails += self.match_requirements r[k],p[k],"#{path}/#{k}"
            end
          end
        end
      }
      fails
    end
  end

end
