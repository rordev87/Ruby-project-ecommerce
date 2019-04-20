module ApplicationHelper
  def get_index index
    index += Settings.client.num_index
  end

  def get_state state
    if state == Order.types[:cancel]
      t "order.cancel"
    elsif state == Order.types[:processing]
      t "order.processing"
    else
      t "order.done"
    end
  end
end
