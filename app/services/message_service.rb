class MessageService
  def self.send_msg(phone, session_id)
    # gem install aliyunsdkcore
    Rails.logger.info '调用短信服务'
    client = RPCClient.new(
      access_key_id:     ENV['AccessKey_ID'],
      access_key_secret: ENV['AccessKey_Secret'],
      endpoint: 'https://dysmsapi.aliyuncs.com',
      api_version: '2017-05-25'
    )

    response = client.request(
      action: 'SendSms',
      params: {
        "RegionId": "cn-hangzhou",
        "PhoneNumbers": "#{phone}",
        "SignName": "宜康",
        "TemplateCode": "SMS_207521596",
        "TemplateParam": "{\"session_id\":\"#{session_id}\"}"
    },
      opts: {
        method: 'POST'
      }
    )

    print response
    Rails.logger.info response

  end
end
