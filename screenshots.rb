# now we need to base64 encode & inline the images

=begin

Documents/NoMatchingElementException-<id>/buttonTests.EarlGreyExampleSwiftTests_testExpectedFailure.png

<section class="test-detail"><img width="20%"
                      src="data:image/png;base64,..."></img></section>

[heading]_[testname].png

<section class="heading" onclick="toggleTests(this);">
            <h3 class="title">buttonTests.EarlGreyExampleSwiftTests</h3>
<td><h3 class="title">testExpectedFailure</h3></td>

<section class="test-detail">/Users/vagrant/git/button/ios/buttonTests/buttonTestEarlGrey.swift:28</section>
=end

require 'rubygems'
require 'nokogiri'
require 'base64'

class Screenshots
  attr_reader :test_screenshots, :screenshot_count

  def initialize
    @test_screenshots = {}
    @screenshot_count = 0
  end

  def run
    populate_screenshot_hash
    inline_screenshots
  end

  def populate_screenshot_hash
    Dir.glob("#{ENV['BITRISE_DEPLOY_DIR']}/Documents/**/*.png").each do |screenshot|
      file_name             = File.basename screenshot, '.*'
      test_class, test_name = file_name.split '_'

      next unless test_class && test_name

      test_screenshots[test_class]            ||= {}
      test_screenshots[test_class][test_name] ||= []
      test_screenshots[test_class][test_name] << screenshot
    end
  end

  def base64 screenshot_path
    Base64.encode64 File.read screenshot_path
  end

  def inline_screenshots
    input_html = Dir.glob("#{ENV['BITRISE_DEPLOY_DIR']}/xcode-test-results-*.html").first
    html       = Nokogiri::HTML(File.read input_html)

    test_classes = html.css('#test-suites section.test-suite')

    test_classes.each do |test_class|
      failed_test_methods = test_class.css 'tr.details'
      test_class_name     = test_class.css('h3.title').first.content.strip
      failed_test_methods.each do |test_method|

        test_method_name = test_method.attributes['class'].value.split(' ').last


        test_screenshots[test_class_name][test_method_name].each do |screenshot|

          image_fragment = Nokogiri::HTML::DocumentFragment.parse <<-HTML
     <section class="test-detail">
       <img width="20%" src="data:image/png;base64,#{base64(screenshot)}" />
     </section>
          HTML

          test_method.css('section.test-detail').last.add_next_sibling image_fragment
          @screenshot_count += 1
        end
      end
    end

    File.write input_html + 'img.html', html.to_html
    puts "encoded #{screenshot_count} screenshot#{screenshot_count > 1 ? 's' : ''}"
  end
end
