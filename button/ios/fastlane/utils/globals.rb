def join(*args)
  File.expand_path(File.join(*args))
end

# Location where commands are executed. Root folder of the repo.
def repo_root_dir
  @repo_root_dir = join(__dir__, '..', '..')
end

def bitrise?
  @bitrise ||= !!ENV['BITRISE_IO']
end

# Ensure bitrise is using bash
if bitrise?
  # /bin/sh is bash on macOS & dash on Ubuntu
  # pipefail doesn't work on dash so default to bash
  system 'sudo ln -sf bash /bin/sh'
end

# Don't buffer.
[$stdout, $stderr].each { |output| output.sync = true }
