module UsersHelper

  def find_user_with_pri_info(id)
    if (user = User.find(id)) && (pri_client = get_client(user.username))
      user.set_info_from_primavera(pri_client)
      user
    else
      nil
    end
  end

end
