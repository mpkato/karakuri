FactoryGirl.define do
  factory :task_template do
    label { Faker::Job.title }
    title_template "{{ query }} {% if iid %}- {{ intent }}{% endif %}"
    form_template <<EOS
<p>「{{query}}」の特に「{{intent}}」に興味があるようなユーザにとっての各情報の重要度を5段階で評価してください</p>

{% assign rates = "0|1|2|3|4" | split: "|" %}
<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>情報</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        {% for iunit in iunits %}
        <tr>
            <td>{{ iunit[0] }}</td>
            <td>{{ iunit[1] }}</td>
            <td>
            <div class="form-group btn-group">

            {% for rate in rates %}
            <label class="btn btn-default">
                <input class="form-control" type="radio" name="{{ iunit[0] }}" value="{{ rate }}" autocomplete="off">
                <span class="radio">{{ rate }}</span>
            </label>
            {% endfor %}
            </div>
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>
EOS
  end

  trait :complex do
    form_template <<EOS
    <input type="radio" name="radio" value="1">
    <input type="radio" name="radio" value="2">
    <input type="text" name="text">
    <input type="hidden" name="hidden">
    <select name="select">
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>
    <textarea name="textarea"></textarea>
EOS
  end

end
