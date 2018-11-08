require "faraday"

def api_post(url,params)
  post_res = Faraday.post url, params.to_json
  return post_res
end