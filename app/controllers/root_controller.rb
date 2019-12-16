class RootController < ApplicationController
  def index
    url = params.require(:url)

    client = Aws::SQS::Client.new({
      access_key_id: ENV["ARTHROPOD_ACCESS_KEY_ID"],
      secret_access_key: ENV["ARTHROPOD_SECRET_ACCESS_KEY"],
      region: ENV["ARTHROPOD_REGION"]
    })
    response = Arthropod::Client.push(queue_name: "waifu2x", client: client, body: {
      image_url: url,
      scale: (params[:scale].present? ? params[:scale] == "true" : true),
      noise_level: params[:noise_level]
    })
    render json: response.body
  end
end
