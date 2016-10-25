class ReportsController < ApplicationController
  def show
    @campaigns = Campaign.all
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token'].to_s
    direct = Ya::API::Direct::Client.new({
      token: token,
      mode: :sandbox
    })
    [Campaign, Keyword].each { |m| m.update_table(direct) }
    redirect_to root_path
  end
end
