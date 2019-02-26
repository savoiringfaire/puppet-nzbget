Puppet::Functions.create_function(:nzb_dir_filter) do
  dispatch :nzb_dir_filter do
    required_param 'Array', :dirs
    required_param 'Array', :filters
    return_type 'Array'
  end

  def nzb_dir_filter(Array dirs, Array filters)
    $result = $filters.map |$filter| {
      if ($filter == '/') {
        $single_filter = dirtree($dirs)
      } else {
        $single_filter = dirtree($dirs.filter |$f| { $filter in $f }, $filter)
      }
    }
    delete(unique(flatten($result)), '')
  end
end
