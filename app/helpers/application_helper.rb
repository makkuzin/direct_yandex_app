module ApplicationHelper
  def get_data_link_name
    (Campaign.count > 0 ? "Обновить" : "Получить") << " данные для отчета"
  end
end
