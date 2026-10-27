class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.order(created_at: :desc)
  end

  def destroy
    Subscriber.find(params.expect(:id)).destroy!
    redirect_to admin_subscribers_path, notice: "Подписчик удалён", status: :see_other
  end
end
