defmodule CbtWeb.Router do
  use CbtWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CbtWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CbtWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/experimenters", ExperimenterController, only: [:index, :show, :new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CbtWeb do
  #   pipe_through :api
  # end



  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
