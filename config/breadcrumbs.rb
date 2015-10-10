crumb :root do
  link "Home", root_path
end

crumb :task_templates do
  link 'Task templates', task_templates_path
  parent :root
end

crumb :task_template do |task_template|
  link task_template.label, task_template_path(task_template)
  parent :task_templates
end

crumb :task_sets do |task_template|
  link 'Task sets', task_template_task_sets_path(task_template)
  parent :task_template, task_template
end

crumb :task_set do |task_set|
  link task_set.label, task_set_path(task_set)
  parent :task_sets, task_set.task_template
end

crumb :assigns do |task_set|
  link 'Assignment', task_set_assigns_path(task_set)
  parent :task_set, task_set
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
