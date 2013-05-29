module BountyHelper
    def accept(bounty_id)
      @bounty = Bounty.find(bounty_id)
      if @bounty.owner == currentUser
        redirect_to root_path, :notice => "You have accepted the bounty."
      else
        redirect_to root_path, :error => "You are not authorized to accept this bounty."
      end
    end

    def reject(bounty_id)
      @bounty = Bounty.find(bounty_id)
      if @bounty.owner == currentUser
        redirect_to root_path, :notice => "You have rejected the bounty."
      else
        redirect_to root_path, :error => "You are not authorized to reject this bounty."
      end
    end

    def accept(bounty_id)
      @bounty = Bounty.find(bounty_id)
      if @bounty.owner == currentUser
        redirect_to root_path, :notice => "You have accepted the bounty."
      else
        redirect_to root_path, :error => "You are not authorized to accept this bounty."
      end
    end
end
