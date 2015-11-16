def rsync_filter_map(items, flag, prepend='', append=''):
  return map(lambda item: "--filter='" + flag + ' ' + prepend + item + append + "'", items)

class FilterModule(object):
  ''' rsync filters '''

  def filters(self):
    return {
      'rsync_filter_map': rsync_filter_map
    }
