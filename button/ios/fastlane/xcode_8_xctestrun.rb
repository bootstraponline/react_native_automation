# Copyright (C) 2016 - present Instructure, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'fastlane'
require 'scan'

module Xcode8
  class << self
    attr_accessor :runner

    # args :scheme - required
    def _xcodebuild(command_name, args)
      raise 'missing opts' unless args
      raise 'opts must be a hash' unless args.is_a?(Hash)

      workspace    = args.fetch(:workspace, nil)
      scheme       = args.fetch(:scheme)
      destination  = args.fetch(:destination, "platform=iOS Simulator,id=#{TEST_SIMULATOR.udid}")
      derived_data = args.fetch(:derived_data, 'xctestrun')

      args = {
          workspace:       workspace,
          scheme:          scheme,
          destination:     destination,
          derivedDataPath: derived_data,
          xcargs:          command_name,
      }

      bitrise_report = ''
      if bitrise?
        bitrise_report_format= 'html'
        bitrise_report_path  = '/Users/vagrant/deploy/xcode-test-results-button.html'
        bitrise_report       = %Q("--report" "#{bitrise_report_format}" "--output" "#{bitrise_report_path}")
      end

      execute_action("xcodebuild #{command_name}") do
        _run_command %Q(
           env "NSUnbufferedIO=YES"
           xcodebuild
             -scheme "#{args[:scheme]}"
             -destination "#{args[:destination]}"
             -derivedDataPath "#{args[:derivedDataPath]}" #{command_name}
           | xcpretty "--color" #{bitrise_report})
      end
    end

    # Executes xcodebuild build-for-testing
    def build_for_testing(args)
      _xcodebuild('build-for-testing', args)
    end

    # Executes xcodebuild test-without-building
    def test_without_building(args)
      _xcodebuild('test-without-building', args)
    end
  end # class << self
end # module Xcode 8
