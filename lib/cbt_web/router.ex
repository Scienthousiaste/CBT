defmodule CbtWeb.Router do
  use CbtWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CbtWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CbtWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CbtWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/experimenters", ExperimenterController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", CbtWeb do
    pipe_through [:browser, :authenticate_experimenter]

    resources "/experiments", TaskController

    get "/form/:id", TaskController, :new_form
    post "/form/:id/post_form", TaskController, :create_form_for_task
  end

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
