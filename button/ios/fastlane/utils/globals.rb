def join(*args)
  File.expand_path(File.join(*args))
end

# Location where commands are executed. Root folder of the repo.
def repo_root_dir
  @repo_root_dir = join(__dir__, '..', '..')
end
