# stdlib
require 'English'
require 'fileutils'

require_relative 'inline_screenshots'

class EarlGreyData
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

  def collect app_id
    # todo: report screenshot inlining only works on bitrise. update to work locally as well.
    return unless bitrise?
    bundle_id = app_id || ENV['APP_BUNDLE_ID']
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
    ui_important "EarlGrey documents found: #{documents_dir}"

    # any files in BITRISE_DEPLOY_DIR wil be attached to the build
    # raw-xcodebuild-output.log is saved there by default.
    #
    # note that any files in a directory won't be attached to the build job.
    # the file dir must be flattened or compressed.
    FileUtils.cp_r documents_dir, ENV['BITRISE_DEPLOY_DIR']

    InlineScreenshots.new.run

    ui_important 'Finished saving test artifacts'
  end
end
