module SortMixin
  def sort(parsed_dictionary, sort_by = nil)
    sort_by ||= "ASC"

    if sort_by == "ASC"
      sorted = parsed_dictionary.sort_by { |key, value| value }
    elsif sort_by == "DESC"
      sorted = parsed_dictionary.sort_by { |key, value| value }.reverse if sort_by == "DESC"
    else
      raise "sort_by must be ASC or DESC"
    end

    sorted
  end
end