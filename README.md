# Ezpay Invoice SDK (Unofficial)
[![Gem Version](https://badge.fury.io/rb/ezpay-invoice.svg)](http://badge.fury.io/rb/ezpay-invoice)

Ruby SDK for Ezpay Invoice.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
  - [Configuration](#configuration)
    - [Global](#global)
    - [Individual](#individual)
  - [Must Know](#must-know)
  - [Invoice Issue](#invoice-issue)
  - [Invoice Touch Issue](#invoice-touch-issue)
  - [Invoice Invalid](#invoice-invalid)
  - [Allowance Issue](#allowance-issue)
  - [Allowance Touch Issue](#allowance-touch-issue)
  - [Allowance Invalid](#allowance-invalid)
  - [Invoice Search](#invoice-search)
  - [Ezpay Error](#ezpay-error)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ezpay-invoice'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ezpay-invoice

Access the library in Ruby:
```ruby
require 'ezpay-invoice'
```

## Usage

### Configuration
使用前需先設定商店相關資料
| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| merchant_id | String | 商店代號 | nil | ✔️ |
| hash_key | String | API串接金鑰 Hash Key | nil | ✔️ |
| hash_iv | String | API串接金鑰 Hash IV | nil | ✔️ |
| mode | String | 測試環境或正式環境 | dev |  |

請注意：預設的環境為 **測試環境**，**如果要使用正式環境開立發票**，請將 `mode` 設定為 `prod`。

Ezpay 後台
- [測試環境](https://cinv.ezpay.com.tw/)
- [正式環境](https://inv.ezpay.com.tw/)

此 SDK 目前僅實作電子發票開立、作廢、折讓、作廢折讓、查詢發票，並無字軌相關功能。

詳細操作請參考 Ezpay 電子發票技術串接手冊
https://inv.ezpay.com.tw/dw_files/info_api/EZP_INVI_1_2_1.pdf

#### Global
可以直接透過 `EzpayInvoice.setup` 設定商店資料，後面進行操作時預設會使用 `EzpayInvoice.config` 的設定進行 Ezpay 的操作

```ruby
EzpayInvoice.setup do |config|
  config.merchant_id = 'your_merchant_id'
  config.hash_key = 'your_hash_key'
  config.hash_iv = 'your_hash_iv'
  config.mode = 'dev' # or prod, default value is dev
end
```

Rails 的使用者可以建立一個 `config/initializers/ezpay_invoice.rb` 檔案，並進行設定:
```ruby
EzpayInvoice.setup do |config|
  config.merchant_id = 'merchant_id_from_yml_or_credential'
  config.hash_key = 'your_hash_key_from_yml_or_credential'
  config.hash_iv = 'your_hash_iv_from_yml_or_credential'
  config.mode = Rails.env == 'production' ? 'prod' : 'dev'
end
```

#### Individual
如果同時有數家商店要各別開立發票的情況，可以通過建立 Client 時才設定商店資料

```ruby
store1 = EzpayInvoice::Client.new({
  merchant_id: 'your_merchant_id',
  hash_key: 'your_hash_key',
  hash_iv: 'your_hash_iv',
  mode: 'prod' # default value is dev
})

store2 = EzpayInvoice::Client.new({
  merchant_id: 'your_merchant_id2',
  hash_key: 'your_hash_key2',
  hash_iv: 'your_hash_iv2',
  mode: 'prod' # default value is dev
})

# store1.invoice_issue({...}) 使用 store1 Client 進行開立發票
# store2.invoice_issue({...}) 使用 store2 Client 進行開立發票
```

### Must Know
欄位皆與手冊上相同，差別在於 naming case 統一是 snake case，另外 item 相關欄位（`item_amt`, `item_name`）等會變成 Array 形態，在 SDK invoke API 時會自動轉換為字串並以 `|` 隔開各筆資料。

建議搭配[官方手冊](https://inv.ezpay.com.tw/dw_files/info_api/EZP_INVI_1_2_1.pdf)看，`RespondType`、`Version`、`TimeStamp` 會預設帶入值，其餘欄位皆與手冊相同，SDK 並未自動預設帶入。

非定義的欄位，自行填入會遭到忽略，例如：
```ruby
client.issue_invoice({ a: 'x' })
```
此時 `a` 欄位並不會被送到 API，因此如果 API 改版，有新增或修改欄位時，就需要更新此 package 所定義的欄位。

另外 `response.result` 會返回 `check_code` 欄位用以驗證 Response 是否為 Ezpay 回傳的資料，SDK 不會幫你做驗證，因為在一些方法缺乏欄位進行驗證，需自行驗證，驗證方式請參考手冊附件二。

### Invoice Issue
`invoice_issue` 開立電子發票方法

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| trans_num | String | ezPay 平台交易序號 | nil |  |
| merchant_order_no | String | 自訂編號 | nil | ✔️ |
| status | String | 開立發票方式 | nil | ✔️ |
| create_status_time | Date | 預計開立日期 | nil |  |
| category | String | 發票種類 | nil | ✔️ |
| buyer_name | String | 買受人名稱 | nil | ✔️ |
| buyer_ubn | String | 買受人統一編號 | nil |  |
| buyer_address | String | 買受人地址 | nil |  |
| buyer_email | String | 買受人電子信箱 | nil |  |
| carrier_type | String | 載具類別 | nil |  |
| carrier_num | String | 載具編號 | nil |  |
| love_code | Integer | 捐贈碼 | nil |  |
| print_flag | String | 索取紙本發票 | nil | ✔️ |
| kiosk_print_flag | String | 是否開放至合作超商 Kiosk 列印 | nil |  |
| tax_type | String | 課稅別 | nil | ✔️ |
| tax_rate | Float | 稅率 | nil | ✔️ |
| customs_clearance | String | 報關標記 | nil |  |
| amt | Integer | 銷售額合計 | nil | ✔️ |
| amt_sales | Integer | 銷售額 (課稅別應稅) | nil |  |
| amt_zero | Integer | 銷售額 (課稅別零稅率) | nil |  |
| amt_free | Integer | 銷售額 (課稅別免稅) | nil |  |
| tax_amt | Integer | 稅額 | nil | ✔️ |
| total_amt | Integer | 發票金額 | nil | ✔️ |
| item_name | String Array | 商品名稱 | nil | ✔️ |
| item_count | Integer Array | 商品數量  | nil | ✔️ |
| item_unit | String Array | 商品單位 | nil | ✔️ |
| item_price | Integer Array | 商品單價 | nil | ✔️ |
| item_amt | Integer Array | 商品小計 | nil | ✔️ |
| item_tax_type | Integer Array | 商品課稅別 | nil |  |
| comment | String | 備註 | nil |  |

使用範例
```ruby
client = EzpayInvoice::Client.new
payload = {
  merchant_order_no: 'G20220101012',
  status: '1',
  category: 'B2B',
  buyer_name: '好人好事代表公司',
  buyer_ubn: '11223344',
  buyer_email: 'your_buyer@email.com',
  print_flag: 'Y',
  tax_type: '1',
  tax_rate: 5,
  amt: 8000,
  tax_amt: 400,
  total_amt: 8400,
  item_name: ['廣告費', '商務車租賃'],
  item_count: [1, 2],
  item_unit: ['筆', '小時'],
  item_price: [5000, 1500],
  item_amt: [5000, 3000],
  item_tax_type: [1, 1]
}
response = client.invoice_issue(payload)
response.status # => "SUCCESS"
response.message # => "發票開立成功"
response.result
# =>  {"check_code"=>"ABCS***********3", "merchant_id"=>"3******2", "merchant_order_no"=>"G20220101013", "invoice_number"=>"ZH10000009", "total_amt"=>8400, "invoice_trans_no"=>"22011614342665747", "random_num"=>"8198", "create_time"=>"2022-01-16 14:34:26", "bar_code"=>"11102ZH100000098198", "q_rcode_l"=>"ZH100000091110116819800001f40000020d01122334461385956p+gqDeGDbLTQM4XuD4sEvQ==:**********:2:2:1:廣告費:1:5000:商務車租賃:2:1500", "q_rcode_r"=>"**"}
```

如果過程中 Ezpay 有返回錯誤代碼，則會直接 `raise EzpayResponseError`，請參考 [Ezpay Error](#ezpay-error) 進行處理

### Invoice Touch Issue
`invoice_touch_issue` 立即觸發等待開立、預約自動開立的發票

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| trans_num | String | ezPay 平台交易序號 | nil |  |
| invoice_trans_no | String | ezPay 電子發票開立序號 | nil | ✔️ |
| merchant_order_no | String | 自訂編號 | nil | ✔️ |
| total_amt | Integer | 發票金額 | nil | ✔️ |

使用範例
```ruby
payload = {
  merchant_order_no: 'G20220101012',
  invoice_trans_no: '22011614342665747',
  total_amt: 8400
}
response = client.invoice_touch_issue(payload)
response.result
```

### Invoice Invalid
`invoice_valid` 作廢發票

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| invoice_number | String | 發票號碼 | nil | ✔️ |
| invalid_reason | String | 作廢原因 | nil | ✔️ |


使用範例
```ruby
payload = {
  invoice_number: 'ZH10000008',
  invalid_reason: '退貨'
}

response = client.invoice_invalid(payload)
response.result
```

### Allowance Issue
`allowance_issue` 開立折讓方法

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| invoice_no | String | 發票號碼 | nil | ✔️ |
| merchant_order_no | String | 自訂編號 | nil | ✔️ |
| item_name | String Array | 折讓商品名稱 | nil | ✔️ |
| item_count | Integer Array | 折讓商品數量 | nil | ✔️ |
| item_unit | String Array | 折讓商品單位 | nil | ✔️ |
| item_price | Integer Array | 折讓商品單價 | nil | ✔️ |
| item_amt | Integer Array | 折讓商品小計 | nil | ✔️ |
| tax_type_for_mixed | Integer | 折讓課稅別 | nil |  |
| item_tax_amt | Integer Array | 折讓商品稅額 | nil | ✔️ |
| total_amt | Integer | 折讓總金額 | nil | ✔️ |
| buyer_email | String | 買受人電子信箱 | nil |  |
| status | String | 確認折讓方式 | nil | ✔️ |

使用範例
```ruby
payload = {
  invoice_no: 'ZH10000010',
  merchant_order_no: 'G20220101014',
  buyer_email: 'junjun.st.tw01@gmail.com',
  item_name: ['廣告費', '商務車租賃'],
  item_count: [1, 2],
  item_unit: ['筆', '小時'],
  item_price: [3000, 1500],
  item_amt: [3000, 3000],
  item_tax_amt: [150, 150],
  tax_type_for_mixed: 1,
  total_amt: 6300,
  status: '1'
}

response = client.allowance_issue(payload)
response.result
```

### Allowance Touch Issue
`allowance_touch_issue` 觸發確認折讓或取消折讓方法

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| allowance_status | String | 觸發折讓狀態  | nil | ✔️ |
| allowance_no | String | 折讓號  | nil | ✔️ |
| merchant_order_no | String | 自訂編號 | nil | ✔️ |
| total_amt | Integer | 折讓總金額 | nil | ✔️ |

使用範例
```ruby
payload = {
  allowance_no: 'A220116015800106',
  allowance_status: 'D',
  merchant_order_no: 'G20220101014',
  total_amt: 6300,
}

response = client.allowance_touch_issue(payload)
response.result
```

### Allowance Invalid
`allowance_invalid` 作廢折讓方法

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| allowance_no | String | 折讓號  | nil | ✔️ |
| invalid_reason | String | 作廢原因  | nil | ✔️ |

使用範例
```ruby
payload = {
  allowance_no: 'A220116015800106',
  invalid_reason: '作廢折讓'
}

response = client.allowance_invalid(payload)
response.result
```

### Invoice Search
`invoice_search` 查詢發票方法

| 欄位 | 型別 | 用途 | 預設 | 必填 |
| :--- | :--- | :--- | :--- | :---: |
| timestamp | Integer | 時間戳 | Time.now.to_i | |
| search_type | String | 查詢方式   | nil |  |
| merchant_order_no | String | 訂單編號  | nil | ✔️ |
| total_amt | String | 發票金額  | nil | ✔️ |
| invoice_number | String | 發票號碼   | nil | ✔️ |
| random_num | String | 發票防偽隨機碼  | nil | ✔️ |
| display_flag | String | 是否於本平台網頁 顯示發票查詢結果  | nil | |

使用範例
```ruby
payload = {
  search_type: '0',
  merchant_order_no: 'G20220101014',
  invoice_number: 'ZH10000008',
  total_amt: '8400',
  random_num: '8856'
}

response = client.invoice_search(payload)
response.result
```

### Ezpay Error
如果使用上述方法時，Ezpay API 端返回文件內所定義的錯誤，如：
| 錯誤代碼 | 錯誤原因 |
| :---: | :---: |
| KEY10002 | 資料解密錯誤 |
| KEY10004 | 資料不齊全 |

更多錯誤代碼請參考[官方手冊](https://inv.ezpay.com.tw/dw_files/info_api/EZP_INVI_1_2_1.pdf)附件九

如果接收到上述錯誤時，則會 raise 一個 `EzpayResponseError` 並將 `status` 與 `message` 存於 Exception 內，想 catch 特定錯誤進行處理時，可以參考下列 pseudo code：

```ruby
begin
  client.inovice_issue(payload)
rescue EzpayInvoice::EzpayResponseError => e
  puts e.status
  puts e.message
  # 錯誤處理
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/whyayen/ezpay-invoice-sdk.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
