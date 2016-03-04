module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def rating_selected?(rating)
    session[:ratings].include?rating
  end
end