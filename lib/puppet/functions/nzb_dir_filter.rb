Puppet::Functions.create_function(:nzb_dir_filter) do
  dispatch :nzb_dir_filter do
    required_param 'Array', :dirs
    required_param 'Array', :filters
    return_type 'Array'
  end

  def nzb_dir_filter(dirs, filters)
    filters.upcase
    dirs
  end
end
