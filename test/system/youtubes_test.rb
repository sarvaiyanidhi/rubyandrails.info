require "application_system_test_case"

class YoutubesTest < ApplicationSystemTestCase
  attr_reader :youtube_course

  def setup
    @youtube_course = youtubes(:youtube_zero)
  end

  test "should display the title" do
    visit youtubes_url
  
    assert_selector "h1", text: "YouTube Courses"
  end

  test "should display youtube course details" do
    visit youtube_url(youtube_course)
    
    assert_selector 'h1', text: youtube_course.title
  end

  test "should search youtube courses with search term" do
    visit youtubes_url
    assert_selector "h1", text: "YouTube Courses about Ruby and Ruby on Rails"

    assert_selector "h3", text: youtube_course.title

    serach_youtube_course_title(youtube_course.title)
    assert_equal true, page.has_content?("Search Term: #{youtube_course.title}")

    assert_selector "h3", text: youtube_course.title
  end

  test "should not show invalid results" do
    visit youtubes_url
    assert_selector "h1", text: "YouTube Courses about Ruby and Ruby on Rails"

    assert_selector "h3", text: youtube_course.title

    serach_youtube_course_title('invalid')
    assert_equal true, page.has_content?("Search Term: invalid")

    # Page should not have that course
    refute_selector "h3", text: youtube_course.title
  end

  private

  def serach_youtube_course_title(title)
    fill_in 'search_term', with: title
    click_button 'Search'
  end
end
