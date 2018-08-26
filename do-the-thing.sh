set -eux

aws iam create-user --user-name "bbl-user"
aws iam put-user-policy --user-name "bbl-user" \
  --policy-name "bbl-policy" \
  --policy-document "$(cat iam-user-policy)"

aws iam create-access-key --user-name "bbl-user" > bbl_access_key
access_key_id=$(jq .AccessKey.AccessKeyId bbl_access_key)
secret_access_key=$(jq .AccessKey.SecretAccessKey bbl_access_key)

bbl up --aws-access-key-id "${access_key_id}" \
  --aws-secret-access-key "${secret_access_key}" \
  --aws-region us-west-1 \
  --iaas aws

bosh deploy -d elasticsearch elasticsearch.yml
