# if Rails.env.production?
#     CarrierWave.configure do |config|
#       config.fog_credentials = {
#         # Amazon S3用の設定
#         :provider              => 'AWS',
#         :region                => ENV['S3_REGION'],     # 例: 'ap-northeast-1'
#         :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
#         :aws_secret_access_key => ENV['S3_SECRET_KEY']
#       }
#       config.fog_directory     =  ENV['S3_BUCKET']
#     end
# end

if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        # Amazon S3用の設定
        :provider              => 'AWS',
        :region                => 'ap-northeast-1',     # 例: 'ap-northeast-1'
        :aws_access_key_id     => 'AKIAIWHM2BDFRVQ2ZMCA',
        :aws_secret_access_key => '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'
      }
      config.fog_directory     =  'my-railstutorial2'
    end
end