module.exports =

  # languages 系统可用的语言，i18n, L10n
  languages: ['zh', 'en']

  # 插件的设置
  plugins: [{
    # 插件的名称
    name: 'pagination'
    # 插件对应的npm库
    module: require 'kiwi-pagination'
    # 插件初始化的参数
    options: {}
  }]
