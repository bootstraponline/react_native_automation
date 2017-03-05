# stdlib
require 'English'
require 'fileutils'

require_relative 'screenshots'

def join(*args)
  File.expand_path(File.join(*args))
end

def app_path(bundle_id)
  path = `xcrun simctl get_app_container booted #{bundle_id}`.strip
  raise 'get_app_container command failed' unless $CHILD_STATUS.success?
  path = join(path, '../' * 4, 'Data/Application')
  raise "path doesn't exit: #{path}" unless File.exist? path
  path
end

def metadata_id(plist)
  result = `/usr/libexec/PlistBuddy -c 'Print MCMMetadataIdentifier' "#{plist}"`.strip
  raise 'PlistBuddy command failed' unless $CHILD_STATUS.success?
  result
end

bundle_id     = ENV['APP_BUNDLE_ID']
raise 'ENV APP_BUNDLE_ID not set' unless bundle_id
search_glob   = join(app_path(bundle_id), '*/.*.plist')
documents_dir = nil

Dir.glob(search_glob) do |plist_path|
  if metadata_id(plist_path) == bundle_id
    documents_dir = join(File.dirname(plist_path), 'Documents')
    break
  end
end

raise 'failed to find documents dir for app' unless documents_dir
puts "EarlGrey documents found: #{documents_dir}"

# any files in BITRISE_DEPLOY_DIR wil be attached to the build
# raw-xcodebuild-output.log is saved there by default.
#
# note that any files in a directory won't be attached to the build job.
# the file dir must be flattened or compressed.
FileUtils.cp_r documents_dir, ENV['BITRISE_DEPLOY_DIR']

# inline screenshots
Screenshots.new.run

puts 'Finished saving test artifacts'