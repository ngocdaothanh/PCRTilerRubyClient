require 'net/http'
require 'uri'

module PCRTiler
  DEFAULTS = {
    'job_name' => 'PCRTilerRubyClient',

    'minimum_tm'     => 60,
    'maximum_tm'     => 63,
    'minimum_length' => 100,
    'maximum_length' => 150,

    'segmentation_type' => 'primer_pair_count',
    'primer_pair_count' => 20,
    'primer_target_length' => 200,

    'filter' => '',

    'total_mismatches'       => 4,
    'three_prime_mismatches' => 2,
    'number_of_candidates'   => 1000,
    'distance_threshold'     => 3000,

    'program' => 'blastn',

    'email' => ''
  }

  ID_PATTERN       = /You will be able to view the results <a href="view.jsp\?id=(.+?)">/
  PROGRESS_PATTERN = /(\d+) of (\d+) oligo pairs have been designed as of yet/

  def self.post_job(base_url, params)
    # Merge params
    posted_params = DEFAULTS.clone
    posted_params.update(params)

    url  = base_url + '/tile.jsp'
    res  = Net::HTTP.post_form(URI.parse(url), posted_params)
    body = res.body

    # Take out id
    m = ID_PATTERN.match(body)
    if m.nil?
      nil
    else
      id = m[1]
      id
    end
  end

  def self.check_job(base_url, id)
    url  = base_url + '/view.jsp?id=' + id
    res  = Net::HTTP.get_response(URI.parse(url))
    body = res.body

    m = PROGRESS_PATTERN.match(body)
    if m.nil?
      txt = download_txt(base_url, id)
      {:status => 'done', :txt => txt}
    else
      done  = m[1].to_i
      total = m[2].to_i
      {:status => 'doing', :done => done, :total => total}
    end
  end

  def self.download_txt(base_url, id)
    url = base_url + '/view.jsp?id=' + id + '&action=download_txt'
    res = Net::HTTP.get_response(URI.parse(url))
    res.body
  end
end
