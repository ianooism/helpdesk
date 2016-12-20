class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :block_non_owner, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @ticket = @project.tickets.build
  end

  def edit
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user

    if @ticket.save
      redirect_to project_ticket_url(@project, @ticket), notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to project_ticket_url(@project, @ticket), notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to project_url(@project), notice: 'Ticket was successfully destroyed.'
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    
    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end
    
    def block_non_owner
      unless @ticket.owner?(current_user)
        redirect_to root_url, alert: "User action was not permitted."
      end
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
