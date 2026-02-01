% Solution to practical Exercise 7

close all;
x = -100:0.5:300;

for std_fac = 1:5:30
    for mean_off = 0:10:50
        % generate normally distributed random observations with mean 15 and standard deviation 10
        o = std_fac*randn(100,1)+mean_off;
        
        % eliminate negative samples
        [col, row] = find (o >= 0);
        o = o(col);

        % compute the Maximum-Likelihood estimate using equation from theory part
        m = mean(o);
        mle = 1/m;

        % log-likelihood array for different settings of parameter a
        LL = [];

        % parameter array (for plotting the function over different parameter settings)
        A = [];

        % compute log-likelihood function for different settings of parameter a
        for a=mle/50:mle/50:mle*2

            % likelihood function
            p = a*exp(-x*a);

            % compute the log-likelihood
            ll = 0;
            for i=1:size(o,1)       
                ll = ll + log(a*exp(-o(i,1)*a));
            end
            LL = [LL ll];
            A = [A a];
        end

        % plot log-likelihood function over parameters
        plot(A, LL)
        axis([min(A(:)) max(A(:)) min(LL(:)) max(LL(:))+50]);
        fprintf('Training samples normally distributet with mean %d and standard deviation %d\n', mean_off, std_fac);
        title('Log-likelihood function of training samples');
        xlabel('lambda');
        ylabel('Log-Likelihood');

        % plot a line at estimated ML estimate
        line([mle mle]', [min(LL) max(LL)+50]');   % plot a line at Maximum-Likelihood solution
        grid;
        pause;
    end
end
