class UserRequest < ApplicationRecord
  after_create :async_flush_request_stats

  def path
    return read_attribute(:path) if read_attribute(:path).present?

    URI.parse(url).path
  end

  def params
    return read_attribute(:params) if read_attribute(:params).present?

    uri = URI.parse url
    CGI.parse(uri.query).reject{|_, v| v.reject(&:empty?).empty?} if uri.query
  end

  private

  def async_flush_request_stats
    flush_request_stats
  end

  def flush_request_stats
    request_stat = RequestStat.where(path: path).first

    if request_stat
      request_stat.count += 1
      request_stat.max_time = [time, request_stat.max_time].max
      request_stat.min_time = [time, request_stat.min_time].min
      request_stat.last_requested_at = created_at
      request_stat.avg_time = UserRequest.where(request_stat_id: request_stat.id).average(:time)
    else
      request_stat = RequestStat.create(
        path: path,
        count: 1,
        max_time: time,
        min_time: time,
        last_requested_at: created_at,
        avg_time: time
      )
    end

    update_attributes request_stat_id: request_stat.id

    params_stats = JSON.parse(request_stat.params_stats || "{}")

    JSON.parse(params).reject{|_, v| !v.present?}.each do |item|
      if item[1].is_a?(Hash)
        item[1].reject{|_, v| !v.present?}.keys.each do |item_key|
          next if item_key.match(/attachment/)
          new_key = "#{item[0]}[#{item_key}]".gsub(/_\d+/, '_#{id}')
          if params_stats.keys.include?(new_key)
            params_stats[new_key] += 1
          else
            params_stats[new_key] = 1
          end
        end
      else
        next if item[0].match(/attachment/)
        new_key = item[0].gsub(/_\d+/, '_#{id}')
        if params_stats.keys.include?(new_key)
          params_stats[new_key] += 1
        else
          params_stats[new_key] = 1
        end
      end
    end

    request_stat.params_stats = JSON[params_stats]
    request_stat.save!
  end
end
