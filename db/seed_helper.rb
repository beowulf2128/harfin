class SeedHelper

  # Creates a record unless it has already been created
  # cls - User
  # attrs_ary - array of attr hashes
  def self.create_from_attrs_ary_once!(cls, attrs_ary)
    attrs_ary.each do |attrs|
      SeedHelper.create_from_attrs_once!(cls, attrs)
    end
  end

  def self.create_from_attrs_once!(cls, attrs)
    if !cls.where(attrs).exists?
      model = cls.create!(attrs)
      puts "  -> created #{attrs}"
      return model
    end
  end

  def self.add_role_to_users(role_name, users)
    r = Role.find_by_name(role_name)
    users.each do |u|
      u.roles << r
    end
  end
end
