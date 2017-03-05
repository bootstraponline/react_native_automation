require 'rubygems'

# stdlib
require 'English'
require 'fileutils'

def join(*args)
  File.expand_path(File.join(*args))
end

def app_path bundle_id
  path = `xcrun simctl get_app_container booted #{bundle_id}`.strip
  raise 'get_app_container command failed' unless $CHILD_STATUS.success?
  path = join(path, '../' * 4, 'Data/Application')
  raise "path doesn't exit: #{path}" unless File.exist? path
  path
end

def metadata_id plist
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

xcode_test_results = ENV['BITRISE_XCODE_RAW_TEST_RESULT_TEXT_PATH']

if xcode_test_results
  FileUtils.cp xcode_test_results, $BITRISE_DEPLOY_DIR
end

FileUtils.cp documents_dir, $BITRISE_DEPLOY_DIR

puts 'Finished saving test artifacts'
