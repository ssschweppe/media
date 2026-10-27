class SubscribersController < ApplicationController
  # Форм подписки две: на заглушке и в футере «О проекте». По placement понимаем, какую обновить
  PLACEMENTS = %w[splash footer].freeze

  def create
    @subscriber = Subscriber.new(subscriber_params)
    @placement = PLACEMENTS.include?(params[:placement]) ? params[:placement] : PLACEMENTS.first

    # Повторная подписка тоже считается успешной: не сообщаем, есть ли адрес в базе
    sent = @subscriber.save || already_subscribed?

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("subscribe-#{@placement}", partial: "subscribers/form",
                 locals: { subscriber: @subscriber, placement: @placement, sent: sent }),
               status: (sent ? :ok : :unprocessable_content)
      end
      format.html do
        redirect_back fallback_location: root_path,
                      notice: (sent ? "Спасибо за подписку!" : @subscriber.errors.full_messages.to_sentence)
      end
    end
  end

  private

  def subscriber_params
    params.expect(subscriber: [ :email, :consent ])
  end

  def already_subscribed?
    @subscriber.errors.attribute_names == [ :email ] && @subscriber.errors.of_kind?(:email, :taken)
  end
end
