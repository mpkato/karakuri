FactoryBot.define do
  factory :task do
    yaml_data { YAML.load("{qid: \"MC2-J-0001\", query: \"ハルク・ホーガン\", iid: 1,
      intent: \"受賞\", iunits: [[\"A\", \"iUnit\"]]}") }
  end
end
