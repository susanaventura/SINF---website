module UsersHelper

  def find_user_with_pri_info(id)
    if (user = User.find(id)) && (pri_client = get_client(user.username))
      user.set_info_from_primavera(pri_client)
      user
    else
      nil
    end
  end

  def remaining_points
    logged_in? ? [0, (current_user.current_points - @cart['total_points']).round].max : 0
  end

end
