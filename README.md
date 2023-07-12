# How to use

### ■初期化
```shell
terraform init
```

### ■実行
```shell
terraform apply -var-file=./env/terraform.tfvars
```

変数の入力を求められます。  
```
var.profile　：　(Optional)使用するプロファイル  
```

### ■削除
```shell
terraform destroy -var-file=./env/terraform.tfvars
```