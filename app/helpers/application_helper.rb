# encoding: UTF-8
module ApplicationHelper

  def add_glasses_link(text, glasses)
    link_to text,
            {:controller => "cart",
             :action => "add",
             :id => glasses},
            remote: true, 
            data: {confirm: "¿Añadir al carro?"}
  end

  def remove_glasses_link(text, glasses)
    link_to text,
            {:controller => "cart",
             :action => "remove",
             :id => glasses},
            remote: true, 
            data: {confirm: "¿Quitar del carro?"}
  end

  def clear_cart_link(text)
    link_to text,
            {:controller => "cart",
             :action => "clear"},
            remote: true, 
            data: {confirm: "¿Vaciar carro?"}
  end

end
